import { spawn } from 'node:child_process';
import { watch } from 'node:fs';
import { copyFile, mkdir } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { resolve } from 'node:path';

const root = resolve(fileURLToPath(new URL('..', import.meta.url)));
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

async function build() {
  if (building) { buildQueued = true; return; }
  building = true;
  try {
    const npmArgs = process.env.npm_execpath ? [process.env.npm_execpath, 'run', 'build:customers:css'] : ['run', 'build:customers:css'];
    await command(process.env.npm_execpath ? process.execPath : 'npm', npmArgs);
    await mkdir(resolve(root, '_site/customers'), { recursive: true });
    await copyFile(resolve(root, 'customers/index.html'), resolve(root, '_site/customers/index.html'));
    await copyFile(resolve(root, 'customers/daisyui.generated.css'), resolve(root, '_site/customers/daisyui.generated.css'));
    console.log('[dev] customers updated; browser live reload will refresh the page');
  } catch (error) {
    console.error('[dev] rebuild failed:', error.message);
  } finally {
    building = false;
    if (buildQueued) { buildQueued = false; build(); }
  }
}

await build();
const wrangler = spawn('npx', ['wrangler', 'dev', '--local', '--port', '8787', '--inspector-port', '0', '--log-level', 'none', '--show-interactive-dev-session=false', '--live-reload'], { cwd: root, stdio: 'inherit' });

function queueBuild() {
  clearTimeout(buildTimer);
  buildTimer = setTimeout(() => build(), 180);
}

watch(resolve(root, 'customers/index.html'), queueBuild);
watch(resolve(root, 'customers/daisyui.css'), queueBuild);

function shutdown() { wrangler.kill('SIGTERM'); }
process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
wrangler.on('exit', code => process.exit(code ?? 0));
