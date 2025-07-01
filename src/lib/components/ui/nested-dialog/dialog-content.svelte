<!-- src/lib/components/ui/nested-dialog/dialog-content.svelte -->
<script lang="ts" module>
  import { cn } from "$lib/utils";
  import { Dialog as DialogPrimitive } from "bits-ui";
  import { X } from "lucide-svelte";
  import { getContext } from "svelte";
  import type { HTMLAttributes } from "svelte/elements";
  import { dialogContext } from "./nested-dialog.svelte";
</script>

<script lang="ts">
  let { class: className, ...props } = $props<HTMLAttributes<HTMLDivElement>>();

  const context = getContext(dialogContext);
  if (!context) throw new Error("DialogContent must be used within a Dialog");

  const { innerOpen } = context;
</script>

<DialogPrimitive.Portal>
  <DialogPrimitive.Overlay
    class={cn(
      "bg-background/40 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 fixed inset-0 z-50 backdrop-blur-sm"
    )} />
  <DialogPrimitive.Content
    class={cn(
      "bg-background data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[state=closed]:slide-out-to-left-1/2 data-[state=closed]:slide-out-to-top-[48%] data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%] fixed top-[50%] left-[50%] z-50 grid w-full max-w-lg translate-x-[-50%] translate-y-[-50%] gap-4 rounded-lg border p-6 shadow-lg duration-200 sm:rounded-lg",
      $innerOpen && "translate-y-[-55%] scale-[0.97]",
      className
    )}
    {...props}>
    <slot />
    <DialogPrimitive.Close
      class="ring-offset-background focus:ring-ring data-[state=open]:bg-accent data-[state=open]:text-muted-foreground absolute top-4 right-4 rounded-sm opacity-70 transition-opacity hover:opacity-100 focus:ring-2 focus:ring-offset-2 focus:outline-none disabled:pointer-events-none">
      <X class="h-4 w-4" />
      <span class="sr-only">Close</span>
    </DialogPrimitive.Close>
  </DialogPrimitive.Content>
</DialogPrimitive.Portal>
