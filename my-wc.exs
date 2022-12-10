nomeArquivo = String.trim(IO.gets("Arquivo: "))

contentFile = File.read!(nomeArquivo)

qtdL = Enum.count(String.split(contentFile, "") |> Enum.filter(fn(x) -> x=="\n" end)) + 1
qtdP = String.split(contentFile, ~r{(\\n|[^\w-])+}) |> Enum.filter(fn(x) -> x != "" end) |> Enum.count()
qtdC = String.split(contentFile, "") |> Enum.filter(fn(x) -> x != "" end) |> Enum.count()

IO.puts ("#{qtdL} #{qtdP} #{qtdC} #{nomeArquivo}")


