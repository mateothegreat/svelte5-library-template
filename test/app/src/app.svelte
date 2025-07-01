<script lang="ts">
  import { Foo, ThemeToggle } from "@mateothegreat/new";
  import Button from "@mateothegreat/new/lib/components/ui/button/button.svelte";
  import { ModeWatcher } from "mode-watcher";
</script>

<ModeWatcher defaultMode="system" />

<div class="p-4">
  <div class="absolute top-4 right-4">
    <ThemeToggle />
  </div>
  <Button>Click me</Button>
  <Foo />
</div>
