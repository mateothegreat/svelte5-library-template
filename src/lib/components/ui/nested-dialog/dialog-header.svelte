<!-- src/lib/components/ui/nested-dialog/dialog-header.svelte -->
<script lang="ts">
  import { cn } from "$lib/utils";
  import type { HTMLAttributes } from "svelte/elements";

  let { class: className, ...props } = $props<HTMLAttributes<HTMLDivElement>>();
</script>

<div class={cn("flex flex-col space-y-1.5 text-center sm:text-left", className)} {...props}>
  <slot />
</div>
