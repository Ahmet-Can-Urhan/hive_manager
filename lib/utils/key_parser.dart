Object parseKey(String input) 
{
  final lower = input.toLowerCase();

  if (lower == 'true') 
  {
    return true;
  }
  if (lower == 'false') 
  {
    return false;
  }
  final intValue = int.tryParse(input);
  if (intValue != null) 
  {
    return intValue;
  }
  final doubleValue = double.tryParse(input);
  if (doubleValue != null) 
  {
    return doubleValue;
  }

  return input;
}
