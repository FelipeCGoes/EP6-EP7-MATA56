defmodule TodoMin do

  def menu(todoList) do
    IO.puts("Menu de opcoes:\n1-carregar TODOs\n2-listar TODOs\n3-apagar TODO\n4-sair")
    op = IO.gets("") |> String.trim()
    case op do
      "1" -> TodoMin.getTodoList()
      "2" -> TodoMin.imprimeTodos(todoList)
      "3" -> TodoMin.removeTodo(todoList)
      "4" -> exit(:shutdown)
      _ -> TodoMin.menu(todoList)
    end
  end

  def getTodoList() do
    nomeArquivo = IO.gets("Insira o nome do arquivo .csv com a lista de TODOs: ") |> String.trim()
    arquivo = Read.readFile(nomeArquivo)
    todoList  = Read.formataCsv(arquivo)
    TodoMin.menu(todoList)
  end

  def imprimeTodos(todoList) do
    toDOs = Map.keys(todoList)
    Enum.each(toDOs, fn item -> 
      IO.puts "--------TODO--------\n"
      IO.puts item
      IO.inspect todoList[item]
      IO.puts "\n"
    end)
    TodoMin.menu(todoList)
  end

  def removeTodo(todoList) do 
    key = IO.gets("Qual TODO voce deseja remover?\n") |> String.trim()
    if Map.has_key?(todoList, key) do
      IO.puts "TODO:#{key} removido\n"
      TodoMin.menu(Map.drop(todoList, [key]))
    else
      IO.puts("TODO:#{key} inexistente na lista\n")
      TodoMin.menu(todoList)
    end
  end
end

defmodule Read do 
  def readFile(filename) do
    case File.read(filename) do
      {:ok, body} -> body
      {:error, _reason} -> IO.puts("Falha ao abrir o arquivo #{filename}.\n")
    end
  end

  def formataCsv(arquivo) do
    raw = String.split(arquivo, ~r{(\r\n|\r|\n)})
    titels = tl (String.split((hd(raw)), ","))
    lines = tl(raw)

    Enum.reduce(lines, %{}, fn line, aux -> 
      [descr | campos] = String.split(line, ",")
      if Enum.count(campos) == Enum.count(titels) do
        line_data = Enum.zip(titels, campos) |> Enum.into(%{})
        Map.merge(aux, %{descr => line_data})
      else 
        aux
      end
    end)
  end
    
    
end

todoList = []

TodoMin.menu(todoList)