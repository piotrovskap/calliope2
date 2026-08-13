import { createServer } from 'node:http';
import { watch } from 'node:fs';
import { readFile, copyFile, stat } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { extname, resolve, normalize, join } from 'node:path';
import { spawn } from 'node:child_process';

const root = resolve(fileURLToPath(new URL('..', import.meta.url)));
const site = resolve(root, '_site');
const port = 8787;
const clients = new Set();
let buildTimer;
let building = false;
let buildQueued = false;

function command(file, args) {
  return new Promise((resolvePromise, reject) => {
    const child = spawn(file, args, { cwd: root, stdio: 'inherit' });
    child.on('error', reject);
    child.on('exit', code => code === 0 ? resolvePromise() : reject(new Error(`${file} exited with ${code}`)));
  });
}

function notifyReload() {
  for (const response of clients) response.write('data: reload\n\n');
}

async function build() {
  if (building) { buildQueued = true; return; }
  building = true;
  try {
    const npmArgs = process.env.npm_execpath ? [process.env.npm_execpath, 'run', 'build:customers:css'] : ['run', 'build:customers:css'];
    await command(process.env.npm_execpath ? process.execPath : 'npm', npmArgs);
    await copyFile(resolve(root, 'index.html'), resolve(site, 'index.html'));
    await copyFile(resolve(root, 'profile.html'), resolve(site, 'profile.html'));
    await copyFile(resolve(root, 'audit-log.html'), resolve(site, 'audit-log.html'));
    await copyFile(resolve(root, 'daisyui.generated.css'), resolve(site, 'daisyui.generated.css'));
    console.log('[dev] static site rebuilt; browser reload sent');
    notifyReload();
  } catch (error) {
    console.error('[dev] rebuild failed:', error.message);
  } finally {
    building = false;
    if (buildQueued) { buildQueued = false; build(); }
  }
}

function queueBuild() {
  clearTimeout(buildTimer);
  buildTimer = setTimeout(() => build(), 180);
}

const contentTypes = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.svg': 'image/svg+xml',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2'
};

async function fileForPath(urlPath) {
  const cleanPath = decodeURIComponent(urlPath.split('?')[0]);
  const relativePath = cleanPath === '/' || cleanPath === '/customers/' ? 'index.html' : cleanPath.replace(/^\/+/, '');
  const sitePath = normalize(join(site, relativePath));
  const sourcePath = normalize(join(root, relativePath));
  if (sitePath.startsWith(site) && await stat(sitePath).then(() => true).catch(() => false)) return sitePath;
  if (sourcePath.startsWith(root) && await stat(sourcePath).then(() => true).catch(() => false)) return sourcePath;
  return null;
}

const server = createServer(async (request, response) => {
  if (request.url === '/__live') {
    response.writeHead(200, { 'Content-Type': 'text/event-stream', 'Cache-Control': 'no-cache', Connection: 'keep-alive', 'Access-Control-Allow-Origin': '*' });
    response.write(': connected\n\n');
    clients.add(response);
    request.on('close', () => clients.delete(response));
    return;
  }

  const filePath = await fileForPath(request.url || '/');
  if (!filePath) { response.writeHead(404); response.end('Not found'); return; }
  try {
    let body = await readFile(filePath);
    if (extname(filePath) === '.html') {
      const liveReload = `<script>new EventSource('/__live').onmessage=()=>location.reload();</script>`;
      body = Buffer.from(body.toString().replace('</body>', `${liveReload}</body>`));
    }
    response.writeHead(200, { 'Content-Type': contentTypes[extname(filePath)] || 'application/octet-stream', 'Cache-Control': 'no-store' });
    response.end(body);
  } catch {
    response.writeHead(500); response.end('Unable to read file');
  }
});

await build();
server.listen(port, '127.0.0.1', () => console.log(`[dev] Customers UI: http://localhost:${port}/`));

watch(resolve(root, 'index.html'), queueBuild);
watch(resolve(root, 'profile.html'), queueBuild);
watch(resolve(root, 'audit-log.html'), queueBuild);
watch(resolve(root, 'daisyui.css'), queueBuild);
watch(resolve(root, 'fonts'), { recursive: false }, queueBuild);

function shutdown() {
  for (const response of clients) response.end();
  server.close(() => process.exit(0));
}
process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
