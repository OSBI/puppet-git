define git::gitoliterepo($ensure, $key){
	
exec { "export gitolite admin for ${name}":
		cwd => "/home/git",
		user => "git",
		environment => "HOME=/home/git",
    	command => "git clone git@localhost:gitolite-admin.git /home/git/gitolite-admin",
    	creates => "/home/git/gitolite-admin",
	}->
	common::concatfilepart {"repo-${name}":
    	ensure  => $ensure,
    	file    => "/home/git/gitolite-admin/conf/gitolite.conf",
    	content => template("git/default-repo.erb"),
  } ->
  exec { "commit gitolite admin for ${name}":
		cwd => "/home/git/gitolite-admin",
		user => "git",
		environment => "HOME=/home/git",
    	command => "git commit conf/gitolite.conf -m \"new repo ${name}\" && git push",
	}
}