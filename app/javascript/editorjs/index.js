import EditorJS from "@editorjs/editorjs";
import Header from "@editorjs/header";
import ImageTool from "@editorjs/image";
import NestedList from "@editorjs/nested-list";
import Quote from "@editorjs/quote";
import RawTool from "@editorjs/raw";
import Delimiter from "@editorjs/delimiter";
import "@sotaproject/strikethrough";

if (!window.EditorJS) { window.EditorJS = {} }
if (!window.EditorJS.Rails) { window.EditorJS.Rails = { tools: {} } }

document.querySelectorAll(".editorjs").forEach(el => {
  const input = el.parentElement.querySelector(`#${el.dataset.input}`);
  const form = input.form;

  let data = {}

  try {
    data = JSON.parse(input.value)
  } catch (e) {
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
            record_type: el.dataset.recordType,
            record_id: el.dataset.recordId,
            name: el.dataset.name,
            authenticity_token: el.dataset.authenticityToken,
          },
        }
      },
      list: NestedList,
      quote: Quote,
      raw: RawTool,
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
