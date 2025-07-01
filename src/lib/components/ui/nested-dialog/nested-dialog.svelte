<!-- src/lib/components/ui/nested-dialog/nested-dialog.svelte -->
<script lang="ts" module>
  import { Dialog as DialogPrimitive } from "bits-ui";
  import { setContext } from "svelte";
  import type { HTMLAttributes } from "svelte/elements";

  interface DialogContextValue {
    innerOpen: boolean;
    setInnerOpen: (value: boolean) => void;
  }

  export const dialogContext = Symbol();
</script>

<script lang="ts">
  let { class: className, ...props } = $props<HTMLAttributes<HTMLDivElement>>();

  const outerOpen = $state(false);
  const innerOpen = $state(false);

  setContext<DialogContextValue>(dialogContext, {
    innerOpen,
    setInnerOpen: (value) => {
      innerOpen = value;
    }
  });
</script>

<DialogPrimitive.Root bind:open={outerOpen} {...props}>
  <slot />
</DialogPrimitive.Root>
