export function init(ctx, payload) {
  ctx.importCSS("main.css");
  ctx.importCSS(
    "https://fonts.googleapis.com/css2?family=Inter:wght@400;500&display=swap"
  );

  ctx.root.innerHTML = `
    <div class="app">
      <div class="header">
        <div class="inline-field">
          <label class="inline-label">Assign to</label>
          <input name="variable"
                 label="Assign to"
                 type="text"
                 placeholder="enter variable name..."></input>
        </div>
        <div class="inline-field">
          <label class="inline-input-label">Choose format:</label>
          <select class="input" name="format">
            <option value="json">JSON</option>
            <option value="iiif">IIIF</option>
          </select>
        </div>
    </div>
      `;

  const variableEl = ctx.root.querySelector(`input[name="variable"]`);
  variableEl.value = payload.variable;

  variableEl.addEventListener("change", (event) => {
    ctx.pushEvent("update_variable", event.target.value);
  });

  ctx.handleEvent("update_variable", (variable) => {
    variableEl.value = variable;
  });

  const formatEl = ctx.root.querySelector(`select[name="format"]`);
  formatEl.value = payload.format;

  formatEl.addEventListener("change", (event) => {
    ctx.pushEvent("update_format", event.target.value);
  });

  ctx.handleEvent("update_format", (format) => {
    formatEl.value = format;
  });

  ctx.handleSync(() => {
    // Synchronously invokes change listeners
    document.activeElement &&
      document.activeElement.dispatchEvent(new Event("change"));
  });
}
