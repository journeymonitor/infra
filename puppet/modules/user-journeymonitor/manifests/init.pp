class user-journeymonitor {

  user { "journeymonitor":
    comment    => "JourneyMonitor",
    home       => "/home/journeymonitor",
    shell      => "/bin/bash",
    uid        => 5999,
    gid        => 5999,
    managehome => "true",
    password   => '$6$BlOg0w3G$s/mjC.5b0P9G7gEqVbmOrOoxk6wvPGE5ZJM8cK1MfiTpH6aJfAJ/zZAdMNZ/mFJBpJChA8ZD75lXUaSUqZDut.',
    groups     => ["journeymonitor"],
  }

  group { "journeymonitor":
    gid => 5999,
  }

  ssh_authorized_key { "journeymonitor-sshkey-manuelkiessling":
    user   => "journeymonitor",
    ensure => present,
    type   => "ssh-dss",
    key    => "AAAAB3NzaC1kc3MAAAEAVx0xr/wD/SYPmYBlyUIaQN3R+1kFYI5bcjTs16Nt5atsnYGT95j8TzHWk7s7xwKI07CTuyW24uftyAgXo5i/onjhla6D5mNul3atATwBgLUBIVGwjD9nsY2Gsv7tAMeAEqUbJ9eKVi0XygbM0uOsQVWaL7LT2lMMowykaVwWjBVwSadOLoYaWo+JjC9+uwSermYn45XRQDEh7cDlbqKhUT8Gox8RZssqRY3gilgoJtYB+RGdB9A/ai6y9Pgcc/FouYKy1Cqgb5F5YcbjkreqMR93H0/KPtX1FD0nABP4XDu79BzwMGkrGZM1JsetH+R2XygeT5OfM5CUWMrSUUbkrQAAABUAml5XqP3ZmbQLot6Vb/PB6jQxafsAAAEATTmCMDJcqMNnoNog4hN90CiEEmC8DpGoI/g7pr1ny0ShcWmuyO7qdhdvUpJyQa3Dwr7Gn1xK+jMdabJGKtojjH3i+mC/nOL4j3QflyOEi8qcLLouYreP2DIEO6WhSiBaoXSefGFg+3vU84uZXCtFEvXgFjlTN/rY4rLZES2xJVwwXeqUEAFLz45OH2+V8xeSID2tcy1Mn1QcaM3LI3N4dzqD/PKq5UVK57V5kzGdTTDY82mNaT0GWfrcCEUxC+U+niGVbgLF5vJTdnXSOpeP/MnXyPenHvMZDjyGOIzOz6HYWj70upc32gXdlSeimb7H2+JXeriHpO+OrWrukkVrWwAAAQATBQIw0W5l0trbbX6sseXL4H852u7DVO2zyIfKIK5uqkQRli8StXDvOL3fgLhNXXG1XkLdMegRlQ/JCXSZNB9xawt1D2FtgIVBWUD7m8imUyhdze4gh+7UOTeCKflgfjCQo/gkVoeS7+Sbw/BDA7l6e7VifDEesEx/8yhKBBYJ2qu/LKy80tI6RbLtTU2RqC5BTUtufZnvlSwSQ3J91rW/jQwGhDHALol2VmGLs85hYTskqNrIu5/oDlyzGFps0hZvCowbfqCQkIlrpvnYvgB46dydnMKXqQi4lCj99e1jN0kFTfuZUbUNsibDuRKKyhXIXi1c9vqdir3+D08vvnRF",
    name   => "Manuel Kiessling <manuel@kiessling.net>",
  }

}