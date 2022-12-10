defmodule MiniMarkdown do
  def to_html(texto) do
    IO.puts (texto |> p |> bold |> italics)
  end

  def italics(texto) do
    Regex.replace(~r{\*(.*)\*}, texto, "<em>\\1</em>")
  end

  def bold(texto) do
    Regex.replace(~r{\*\*(.*)\*\*}, texto, "<strong>\\1</strong>")
  end

  def p(texto) do
    Regex.replace(~r{(\r\n|\n|\r|^)+([^\r\n]+)((\r\n|\n|\r)+$)?}, texto, "<p>\\2</p>")
  end
end

texto = """
Esse é um texto de **teste**

Devera colocar *corretamente as tags*
"""

MiniMarkdown.to_html(texto)