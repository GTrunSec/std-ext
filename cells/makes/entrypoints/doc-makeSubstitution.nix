{
  __nixpkgs__,
  makeTemplate,
  __output__,
}:
makeTemplate {
  name = "make-template";
  replace = __output__.documents.makes;
  template = ../../doc/doc.ncl;
}
