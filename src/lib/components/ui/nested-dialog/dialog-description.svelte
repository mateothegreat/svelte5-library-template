<!-- src/lib/components/ui/nested-dialog/dialog-description.svelte -->
<script lang="ts">
  import { cn } from "$lib/utils";
  import { Dialog as DialogPrimitive } from "bits-ui";
  import type { HTMLAttributes } from "svelte/elements";

  let { class: className, ...props } = $props<HTMLAttributes<HTMLParagraphElement>>();
</script>

<DialogPrimitive.Description class={cn("text-muted-foreground text-sm", className)} {...props}>
  <slot />
</DialogPrimitive.Description>
