proc getAlphabet(): string =
  for letter in 'a'..'z':
    result.add(letter)

proc main(): void =
  const alphabet = getAlphabet() 
  echo alphabet

main()
