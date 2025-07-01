<!-- src/lib/components/ui/nested-dialog/dialog-title.svelte -->
<script lang="ts">
  import { cn } from "$lib/utils";
  import { Dialog as DialogPrimitive } from "bits-ui";
  import type { HTMLAttributes } from "svelte/elements";

  let { class: className, ...props } = $props<HTMLAttributes<HTMLHeadingElement>>();
</script>

<DialogPrimitive.Title
  class={cn("text-lg leading-none font-semibold tracking-tight", className)}
  {...props}>
  <slot />
</DialogPrimitive.Title>
