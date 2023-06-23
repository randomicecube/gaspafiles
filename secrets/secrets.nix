let
  bentleySystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMb7YSjXp64cvHasDhgyWGmYHg63ZKbFoCnGkPoWMsKZ";
  clockwerkSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK3UGLE0qEeVJasmzNaPHw5VsqNoUyjxTjO9JZL95UhA";
  slySystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH1z3pPqbGtSLABFGKYrSbZ1wq+j8e8W9Nobyn1yrhB7";
  systems = [ bentleySystem clockwerkSystem slySystem ];

  bentleyUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2XabbFMuMGrsHJRhj/91KlrFNWSgnSn5qNfufzqHeA";
  clockwerkUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgZUGgluhhI6Pg+LCp70WCy2YX12of8Cc6cO6JQJDzy";
  slyUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIPXnaZy4Pk+3qL6dx4iBnPCLTpGgf8yzhkPe1AcR+/K";
  users = [ bentleyUser clockwerkUser slyUser ];
in {
  "slyMachineAddress.age".publicKeys = systems ++ users;
}
