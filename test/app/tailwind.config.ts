import type { Config } from "@tailwindcss/vite";

const config: Config = {
  content: ["../../src/**/*.{html,js,svelte,ts}", "./src/**/*.{html,js,svelte,ts}"],
  // Export the content patterns for consuming apps
  safelist: [
    // Add critical classes that might be missed
    "data-[state=open]:animate-accordion-down",
    "data-[state=closed]:animate-accordion-up"
  ]
};

export default config;
