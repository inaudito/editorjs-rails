import EditorJS from "@editorjs/editorjs";
import "@editorjs/header";
import "@editorjs/image";
import "@editorjs/nested-list";
import "@editorjs/quote";
import "@editorjs/delimiter";
import "@sotaproject/strikethrough";

if (!window.EditorJS) { window.EditorJS = {} }
if (!window.EditorJS.Rails) { window.EditorJS.Rails = { tools: {} } }

document.querySelectorAll(".editorjs").forEach(el => {
  const input = el.parentElement.querySelector(`#${el.dataset.input}`);
  const form = input.form;

  let data = {}

  try {
    data = JSON.parse(input.value)
  } catch(e) {
    console.error(e)
  }

  const editor = new EditorJS({
    tools: {
      header: Header,
      image: {
        class: ImageTool,
        config: {
          endpoints: {
            byFile: el.dataset.uploadImageUrl,
            byUrl: el.dataset.uploadImageUrl,
          },
          additionalRequestData: {
            authenticity_token: el.dataset.authenticityToken,
          },
        }
      },
      list: NestedList,
      quote: Quote,
      delimiter: Delimiter,
      strikethrough: Strikethrough,
      ...window.EditorJS.Rails.tools,
    },
    holder: el,
    data,
  });

  form.addEventListener("submit", async () => {
    const data = await editor.save();
    input.value = JSON.stringify(data);
  });
});
