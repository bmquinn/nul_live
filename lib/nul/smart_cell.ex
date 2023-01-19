defmodule Nul.SmartCell do
  use Kino.JS, assets_path: "lib/assets/smart_cell"
  use Kino.JS.Live
  use Kino.SmartCell, name: "NUL Digital Collections API"

  @impl true
  def init(attrs, ctx) do
    format = attrs["format"] || "json"
    variable = Kino.SmartCell.prefixed_var_name("result", attrs["variable"])

    default_source =
      """
      {
        "query": {
          "match_all": {}
        }
      }
      """
      |> String.trim()

    {:ok, assign(ctx, format: format, variable: variable),
     editor: [attribute: "query_body", language: "json", default_source: default_source]}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, %{format: ctx.assigns.format, variable: ctx.assigns.variable}, ctx}
  end

  @impl true
  def handle_event("update_variable", variable, ctx) do
    ctx =
      if Kino.SmartCell.valid_variable_name?(variable) do
        assign(ctx, variable: variable)
      else
        ctx
      end

    broadcast_event(ctx, "update_variable", ctx.assigns.variable)

    {:noreply, ctx}
  end

  def handle_event("update_format", format, ctx) do
    broadcast_event(ctx, "update_format", format)
    {:noreply, assign(ctx, format: format)}
  end

  @impl true
  def to_attrs(ctx) do
    %{"format" => ctx.assigns.format, "variable" => ctx.assigns.variable}
  end

  @impl true
  def to_source(attrs) do
    url = "https://api.dc.library.northwestern.edu/api/v2/search?as=#{attrs["format"]}"

    quote do
      unquote(quoted_variable(attrs["variable"])) =
        Req.post!(unquote(url),
          body: unquote(attrs["query_body"])
        ).body
    end
    |> Kino.SmartCell.quoted_to_string()
  end

  defp quoted_variable(nil), do: nil
  defp quoted_variable(str), do: {String.to_atom(str), [], nil}
end
