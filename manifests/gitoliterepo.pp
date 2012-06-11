define git::gitoliterepo($ensure, $key){
	
	exec { "export gitolite admin for ${name}":
		cwd => "/home/git",
		user => "git",
		environment => "HOME=/home/git",
    	command => "git clone git@localhost:gitolite-admin.git /home/git/gitolite-admin",
    	creates => "/home/git/gitolite-admin",
	} ->
  	exec { "commit gitolite admin for ${name}":
		cwd => "/home/git/gitolite-admin",
		user => "git",
		environment => "HOME=/home/git",
    	command => "git commit conf/gitolite.conf -m \"new repo ${name}\" && git push ; mkdir -p /home/git/committed/ ; touch /home/git/committed/${name}",
    	creates => "/home/git/committed/${name}"
	}
}