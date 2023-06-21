let
  bentleySystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2XabbFMuMGrsHJRhj/91KlrFNWSgnSn5qNfufzqHeA";
  clockwerkSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK3UGLE0qEeVJasmzNaPHw5VsqNoUyjxTjO9JZL95UhA";
  slySystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH1z3pPqbGtSLABFGKYrSbZ1wq+j8e8W9Nobyn1yrhB7";
in {
  # "nebulaCA.age".publicKeys = [ bentleySystem clockwerkSystem slySystem ];
  # "openvpnIstAuthUserPass.age".publicKeys = [ bentleySystem slySystem ];

  # "bentley/nebulaCert.age".publicKeys = [ bentleySystem ];
  # "bentley/nebulaKey.age".publicKeys = [ bentleySystem ];

  # "clockwerk/nebulaCert.age".publicKeys = [ clockwerkSystem ];
  # "clockwerk/nebulaKey.age".publicKeys = [ clockwerkSystem ];

  # "sly/nebulaCert.age".publicKeys = [ slySystem ];
  # "sly/nebulaKey.age".publicKeys = [ slySystem ];
}
