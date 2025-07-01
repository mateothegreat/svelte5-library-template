<!-- src/lib/components/ui/nested-dialog/dialog-footer.svelte -->
<script lang="ts">
  import { cn } from "$lib/utils";
  import type { HTMLAttributes } from "svelte/elements";

  let { class: className, ...props } = $props<HTMLAttributes<HTMLDivElement>>();
</script>

<div class={cn("flex flex-col-reverse sm:flex-row sm:space-x-2", className)} {...props}>
  <slot />
</div>
