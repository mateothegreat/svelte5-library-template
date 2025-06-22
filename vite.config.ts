import { svelte } from "@sveltejs/vite-plugin-svelte";
import path from "path";
import { defineConfig } from "vite";
import tsconfigPaths from "vite-tsconfig-paths";

export default defineConfig({
  plugins: [tsconfigPaths(), svelte()],
  resolve: {
    alias: {
      $lib: path.resolve(__dirname, "./src/lib"),
      $variants: path.resolve(__dirname, "./src/variants")
    }
  }
});
