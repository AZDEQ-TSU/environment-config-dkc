#
# base profile includes component modules that will be on all nodes
#

class profile::base {

  sysctl { 'net.ipv4.ip_forward':
  ensure  => present,
  value   => '0',
  apply   => true,
  persist => true,
}
  group { 'dcrowfo':
    gid => 1501,
  }
  group { 'admins':
    gid => 1800,
  }
  user { 'dcrowfo':
    ensure         => present,
    uid            => 1501,
    gid            => 1501,
    comment        => 'Dave Crowfoot',
    groups         => 'admins',
    shell          => '/bin/bash',
    home           => '/home/dcrowfo',
    managehome     => true,
    purge_ssh_keys => true,
  }
  ssh_authorized_key { 'dcrowfo':
    ensure => present,
    user   => 'dcrowfo',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAAEAQC80IFhgyL7wLI7fsAj82q3Kx9JgS/kjjHDaVyODraxATVuKGyeNtfvJ2nTHb/HAriB8mghAzhgtL7OPW3pVEwtaRIlnrLe
Q8gxSBjipGYZNUBXISYzYHQRi7Wxgw4C4vj120kpwVNcIyzyItjGyE0znlEBaYB4JLZq4JBoVIlnto85dm6h7l85Ig1hG2V4ost1PhYGaJrooIbcsO3u0k7P//xkiTGDk2dr
Mmu/ralU+i3OXhJPExWvw6uPdRVci5HVW2fslb5Y6cFOC80+BDDloOnOOjDGhJYPVi/mncMBszJbRTVfCQvBHMr4RbvsZRmf2ikKv46qzuReco7mu1uL7HtRhSc718PyiAEk
5H3BoB7rk2qDqc8rAmef298m7XTH7cBQpPu6onS0SOPyXIPn6eI3iniSaysE3r2sTxWyDWg20l6/cCTwEu0dU6c1K4FUQDw2892mz9xGSJY9JcfKvBa0FujdM+kiIuV49iCa
lJaU13nhCkMAft5VFKTDRsojvxZbhYZCX6PbqkD72AYhdrYPaq1cTG22ARaAaiGjqOVxVCz6UG7mtT9vL4iyH+KRZgxIOctZ0gYaPPccAlGwj/Vj7D0olZHfjnWo+dditoq8
QUpHsaYbs4Uioot8oex1X2T7MW7PRdi+OgwZhhyPVuyUvxXiqG4J2losoY9p5HB1jEN9t/7+++QNHYsKZeUeWHRC4CTx8ZzRshv9jlLvk7dWdQq2uVk/GxIHCqfoImD8ggsq
IF6Gdriia+ITW7Re72j1AwFk0lA1+ykYPU+Q05itOjB/mKS0R0GkeIVISmCXWUgrhWIb61Ep28CQNKqDVZ8qB2ijcTTsqYok//nxuCl3eFz/ScfnYjpyuk4slk/fuxyAFldu
npA1pu66jLRmlKoKA5wKtAyqhyVVqyS/8xrLeHfDvbjBvcKVcZrx55dATJIL4Jgn68EesFPeKdU/udwy7SAs5Kx3v87Z3x6XEs65q/FBGHU+77rjNNA8qx2ZTJQ4FbroPL/k
chyxi4fy5V7d35r1iuWn944nEzK8FfONCFiiyd/El6haA2neqeZMe/4dNrDX9Xo/XwHfpj6MmVN4ZAr8DD/fMB7TZAsollJum1dFJ/KYGjn2zUMjwJYPoOGno2rQ0bV5XtPY
4btozN19uMcPpulgc/Sqabw59IG58LNYdX4XlZM0V4ghk7wHno0rv5pPwsy1DBQB1gZxCNQEa8ZzRbSGLa7dzQTerT9A5cuZLGdQnN9wWteTyxdKqunClxHh30302+Ij21/m
ijqWHrZA/BkGOZdEErieJxQbHOb31G1sd9J45i1+8As7wll+RJzMBzZD0gRTuENwisFbEfkfI4AcEACqRWab',
  }
  sudo::conf { 'admins':
    priority => 10,
    content  => '%admins ALL=(ALL) NOPASSWD: ALL',
    require  => Group['admins'],
  }
  sudo::conf { 'nessus':
    priority => 10,
    content  => 'svc_nessus_scan ALL=(ALL) NOPASSWD: ALL',
  }
}
