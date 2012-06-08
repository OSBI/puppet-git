define git::gitoliterepo($ensure){
	
	exec { "export gitolite admin":
    	command => "git clone git@localhost:gitolite-admin.git /home/git/gitolite-admin",
    	creates => "/home/git/gitolite-admin",
	} ->
	common::concatfilepart {"repo-${name}":
    	ensure  => $ensure,
    	file    => "/home/git/gitolite-admin/conf/gitolite.conf",
    	content => template("git/default-repo.erb"),
  }
}