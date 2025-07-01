<!-- src/lib/components/ui/nested-dialog/inner-dialog-content.svelte -->
<script lang="ts" module>
  import { cn } from "$lib/utils";
  import { Dialog as DialogPrimitive } from "bits-ui";
  import { X } from "lucide-svelte";
  import { getContext } from "svelte";
  import type { HTMLAttributes } from "svelte/elements";
  import { dialogContext } from "./nested-dialog.svelte";

  export type Position = "default" | "bottom" | "top" | "left" | "right";
</script>

<script lang="ts">
  interface $$Props extends HTMLAttributes<HTMLDivElement> {
    position?: Position;
    draggable?: boolean;
  }

  let { class: className, position = "default", draggable = false, ...props } = $props<$$Props>();

  const context = getContext(dialogContext);
  if (!context) throw new Error("InnerDialogContent must be used within a Dialog");

  const { innerOpen, setInnerOpen } = context;

  const isDragging = $state(false);
  const startY = $state(0);
  const currentY = $state(0);
  const isClosingByDrag = $state(false);
  let contentRef: HTMLDivElement;

  $effect(() => {
    if ($innerOpen) {
      currentY = 0;
      isClosingByDrag = false;
    }
  });

  function handlePointerDown(e: PointerEvent) {
    if (!draggable) return;
    isDragging = true;
    startY = e.clientY - currentY;
    (e.currentTarget as HTMLElement).setPointerCapture(e.pointerId);
  }

  function handlePointerMove(e: PointerEvent) {
    if (!isDragging || !draggable) return;
    const newY = e.clientY - startY;
    currentY = newY > 0 ? newY : 0;
  }

  function handlePointerUp() {
    if (!draggable) return;
    isDragging = false;
    if (currentY > (contentRef?.offsetHeight || 0) / 2) {
      isClosingByDrag = true;
      setInnerOpen(false);
    } else {
      currentY = 0;
    }
  }
</script>

<DialogPrimitive.Portal>
  <DialogPrimitive.Content
    bind:elementRef={contentRef}
    on:pointerdown={handlePointerDown}
    on:pointermove={handlePointerMove}
    on:pointerup={handlePointerUp}
    style="transform: translate(-50%, calc(-50% + {currentY}px)); transition: {isDragging
      ? 'none'
      : 'transform 0.3s ease-out'}"
    class={cn(
      "bg-background fixed top-[50%] left-[50%] z-[60] grid w-full max-w-lg translate-x-[-50%] translate-y-[-45%] gap-4 rounded-lg border p-6 shadow-lg duration-200",
      isClosingByDrag
        ? "data-[state=closed]:fade-out-0 data-[state=closed]:animate-none"
        : "data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[state=closed]:slide-out-to-left-1/2 data-[state=closed]:slide-out-to-top-[48%] data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%]",
      position === "default" &&
        "data-[state=closed]:slide-out-to-left-1/2 data-[state=closed]:slide-out-to-top-[48%] data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%]",
      position === "bottom" &&
        "data-[state=closed]:slide-out-to-bottom-full data-[state=open]:slide-in-from-bottom-full",
      position === "top" &&
        "data-[state=closed]:slide-out-to-top-full data-[state=open]:slide-in-from-top-full",
      position === "left" &&
        "data-[state=closed]:slide-out-to-left-full data-[state=open]:slide-in-from-left-full",
      position === "right" &&
        "data-[state=closed]:slide-out-to-right-full data-[state=open]:slide-in-from-right-full",
      draggable && "",
      className
    )}
    {...props}>
    <div bind:this={contentRef}>
      <slot />
    </div>
    <DialogPrimitive.Close
      class="ring-offset-background focus:ring-ring data-[state=open]:bg-accent data-[state=open]:text-muted-foreground absolute top-4 right-4 rounded-sm opacity-70 transition-opacity hover:opacity-100 focus:ring-2 focus:ring-offset-2 focus:outline-none disabled:pointer-events-none">
      <X class="h-4 w-4" />
      <span class="sr-only">Close</span>
    </DialogPrimitive.Close>
  </DialogPrimitive.Content>
</DialogPrimitive.Portal>
