import type { Preview } from "@storybook/react";
import "../src/index.css";

const preview: Preview = {
  parameters: {
    controls: { matchers: { color: /(background|color)$/i, date: /Date$/i } },
    backgrounds: {
      default: "calliope-navy",
      values: [
        { name: "calliope-navy", value: "#162345" },
        { name: "navy-deep", value: "#0E1730" },
        { name: "light", value: "#ffffff" },
      ],
    },
  },
};

export default preview;
