define git::hook($ensure = "present", $source ='' ) {
	
	file {
		"/home/git/.gitolite/hooks/common/$name" :
			mode => 755,
			owner => git,
			group => git,
			source => $source,
	} ->
	exec {
		"update-gitolite $name" :
			cwd => "/home/git",
			command => "/usr/bin/gl-setup /home/git/.ssh/id_rsa.pub",
			#creates => "/home/git/repositories/etl.git/hooks/post-receive",
			unless => "grep \"#FILE CHECK DO NOT REMOVE\" /home/git/repositories/gitolite-admin.git/hooks/post-receive",
			user => "git",
			environment => "HOME=/home/git",
	}
}