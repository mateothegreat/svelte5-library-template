import { svelte } from "@sveltejs/vite-plugin-svelte";
import { svelteInspector } from "@sveltejs/vite-plugin-svelte-inspector";
import { defineConfig } from "vite";
import tsconfigPaths from "vite-tsconfig-paths";

import tailwindcss from "@tailwindcss/vite";

import path from "path";
import { vitePluginVersionMark } from "vite-plugin-version-mark";

export default defineConfig({
  plugins: [
    tsconfigPaths(),
    tailwindcss(),
    vitePluginVersionMark({
      name: "my-app",
      ifGitSHA: true,
      ifShortSHA: true,
      ifMeta: true,
      ifLog: true,
      ifGlobal: true
    }),
    svelte(),
    svelteInspector({
      toggleKeyCombo: "alt-x",
      showToggleButton: "always",
      toggleButtonPos: "bottom-left"
    })
  ],
  resolve: {
    alias: {
      $lib: path.resolve(__dirname, "../../src/lib"),
      $variants: path.resolve(__dirname, "../../src/variants")
    }
  }
});
