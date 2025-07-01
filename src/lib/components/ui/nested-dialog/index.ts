import { Dialog as DialogPrimitive } from "bits-ui";
import Content from "./dialog-content.svelte";
import Description from "./dialog-description.svelte";
import Footer from "./dialog-footer.svelte";
import Header from "./dialog-header.svelte";
import Title from "./dialog-title.svelte";
import InnerDialogContent from "./inner-dialog-content.svelte";
import InnerDialogRoot from "./inner-dialog.svelte";
import Root from "./nested-dialog.svelte";

export {
  Content,
  Description,
  //
  Root as Dialog,
  DialogPrimitive as DialogClose,
  Content as DialogContent,
  Description as DialogDescription,
  Footer as DialogFooter,
  Header as DialogHeader,
  DialogPrimitive as DialogOverlay,
  //
  DialogPrimitive as DialogPortal,
  Title as DialogTitle,
  DialogPrimitive as DialogTrigger,
  Footer,
  Header,
  InnerDialogRoot as InnerDialog,
  InnerDialogContent,
  InnerDialogContent,
  InnerDialogRoot,
  Root,
  Title,
  type Position as InnerDialogPosition
};

export type { Position } from "./inner-dialog-content.svelte";
