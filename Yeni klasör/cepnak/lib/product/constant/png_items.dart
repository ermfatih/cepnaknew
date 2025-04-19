enum PngItems{
  bed,
  car,
  cepnaktext,
  expensive,
  freights,
  home,
  down,
  lock,
  carlogo,
  map,
  moon,
  notification,
  oldFreights,
  phone,
  profile,
  send,
  truck,
  man,
  location,
  round,
  wait,
  request,
  filter,
  trucks,
  locations,
  walk,
  tonnage,
  time,
  cepnaklogo,
  commission,
  rightcodelogo


}
extension PngItemsExtension on PngItems{
  String _path(){
    return name;
  }

  String get pngPath =>'assets/png/${_path()}.png';
}