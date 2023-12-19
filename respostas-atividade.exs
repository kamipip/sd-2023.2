# Questão 1
defmodule MeuModulo do
  def minha_funcao do
    IO.puts "Olá, mundo!"
  end
end

# Questão 2 
defmodule MeuModulo do
  def minha_funcao(nome) do
    IO.puts "Olá, #{String.trim(nome)}!"
  end
end

# Questão 3
defmodule Saudacao do
  def run do
    IO.puts "Digite seu nome:"
    nome = IO.gets()

    IO.puts "Digite seu ano de nascimento:"
    ano_nascimento = IO.gets()

    case Integer.parse(String.trim(ano_nascimento)) do
      {ano, ""} when ano > 0 ->
        idade = Date.utc_today().year() - ano
        IO.puts "Olá, #{String.trim(nome)}, você tem #{idade} anos."
      _ ->
        IO.puts "Ano de nascimento inválido. Tente novamente."
        run()
    end
  end
end

Saudacao.run()

# Questão 4
defmodule CalculoIMC do
  def calcular_imc(nome, peso_kg, altura_m) do
    if peso_kg <= 0 or altura_m <= 0 do
      "Peso e altura devem ser maiores que zero."
    else
      imc = peso_kg / (altura_m * altura_m)
      "Olá #{nome}, seu IMC é de #{imc |> Float.round(1) |> Float.to_string}."
    end
  end
end

IO.puts("Digite seu nome:")
nome = IO.gets() |> String.trim()

IO.puts("Digite seu peso em Kg:")
peso = IO.gets() |> String.trim() |> String.to_float()

IO.puts("Digite sua altura em metros:")
altura = IO.gets() |> String.trim() |> String.to_float()

mensagem = CalculoIMC.calcular_imc(nome, peso, altura)
IO.puts(mensagem)

# Questão 5
defmodule SequenciaInversa do
  def ler_e_exibir_inverso(n) do
    numeros = ler_numeros(n)
    inverso = Enum.reverse(numeros)
    IO.puts("Sequência inversa: #{inverso}")
  end

  defp ler_numeros(n) do
    IO.puts("Digite a sequência de #{n} números inteiros (um por linha):")
    Enum.map(1..n, fn _ ->
      IO.gets("") |> String.trim() |> String.to_integer()
    end)
  end
end

IO.puts("Digite a quantidade de números:")
quantidade = IO.gets("") |> String.trim() |> String.to_integer()

SequenciaInversa.ler_e_exibir_inverso(quantidade)

# Questão 6
defmodule ArmazenarMatriculasNomes do
  def ler_e_armazenar(quantidade) do
    matriculas_nomes = ler_matriculas_nomes(quantidade)
    dicionario = Enum.into(matriculas_nomes, %{})
    IO.inspect(dicionario)
  end

  defp ler_matriculas_nomes(quantidade) do
    IO.puts("Digite os pares matrícula/nome (um por linha):")
    Enum.map(1..quantidade, fn _ ->
      {matricula, nome} = ler_matricula_nome()
      {matricula, nome}
    end)
  end

  defp ler_matricula_nome do
    IO.puts("Matrícula:")
    matricula = IO.gets("") |> String.trim()

    IO.puts("Nome:")
    nome = IO.gets("") |> String.trim()

    {matricula, nome}
  end
end

IO.puts("Digite a quantidade de pares matrícula/nome:")
quantidade = IO.gets("") |> String.trim() |> String.to_integer()

ArmazenarMatriculasNomes.ler_e_armazenar(quantidade)

# Questão 7
defmodule SistemaCRUD do
  defstruct x: 0, y: 0

  @pontos %{}

  def principal do
    menu()
  end

  def menu do
    IO.puts("Sistema CRUD")
    IO.puts("============")
    IO.puts("1. Criar ponto")
    IO.puts("2. Listar pontos")
    IO.puts("3. Atualizar ponto")
    IO.puts("4. Excluir ponto")
    IO.puts("5. Sair")
    IO.puts("Entre com sua opção:")

    opcao = IO.gets(" |> ")
    opcao = String.trim(opcao) |> String.to_integer()

    case opcao do
      1 -> criar_ponto()
      2 -> listar_pontos()
      3 -> atualizar_ponto()
      4 -> excluir_ponto()
      5 -> sair()
      _ -> menu()
    end
  end

  def criar_ponto do
    IO.puts("Função Criar Ponto")
    IO.puts("Digite o número do ponto:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    IO.puts("Digite a coordenada x:")
    coordenada_x = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    IO.puts("Digite a coordenada y:")
    coordenada_y = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = %SistemaCRUD{x: coordenada_x, y: coordenada_y}
    @pontos = Map.put(@pontos, numero, ponto)

    IO.puts("Ponto criado com sucesso!")
    menu()
  end

  def listar_pontos do
    IO.puts("Função Listar Pontos")

    pontos = @pontos

    Enum.each(Map.keys(pontos), fn numero ->
      ponto = Map.get(pontos, numero)
      IO.puts("Ponto #{numero}: x = #{ponto.x}, y = #{ponto.y}")
    end)

    menu()
  end

  def atualizar_ponto do
    IO.puts("Função Atualizar Ponto")
    IO.puts("Digite o número do ponto a ser atualizado:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(@pontos, numero)

    if ponto do
      IO.puts("Digite a nova coordenada x:")
      coordenada_x = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      IO.puts("Digite a nova coordenada y:")
      coordenada_y = IO.gets(" |> ") |> String.trim() |> String.to_integer()

      ponto = %SistemaCRUD{x: coordenada_x, y: coordenada_y}
      @pontos = Map.put(@pontos, numero, ponto)

      IO.puts("Ponto atualizado com sucesso!")
    else
      IO.puts("Ponto não encontrado.")
    end

    menu()
  end

  def excluir_ponto do
    IO.puts("Função Excluir Ponto")
    IO.puts("Digite o número do ponto a ser excluído:")
    numero = IO.gets(" |> ") |> String.trim() |> String.to_integer()

    ponto = Map.get(@pontos, numero)

    if ponto do
      @pontos = Map.delete(@pontos, numero)
      IO.puts("Ponto excluído com sucesso!")
    else
      IO.puts("Ponto não encontrado.")
    end

    menu()
  end

  def sair do
    IO.puts("Saindo...")
  end
end

# Questão 8

