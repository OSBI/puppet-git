define git::gitoliteimport($repo, $directory=false, $subdir=""){
	
	exec { "export ${repo} repo for ${name}":
		cwd => "/home/git",
		user => "git",
		environment => "HOME=/home/git",
    	command => "git clone git@localhost:${repo}.git /home/git/${repo}",
    	creates => "/home/git/${repo}",
	}
	if ($directory) {
			exec { "copy directory ${name}":
			cwd => "/home/git",
			user => "git",
			environment => "HOME=/home/git",
    		command => "cp -rf ${name} /home/git/${repo}/${subdir}",
    		creates => "/home/git/${repo}/${subdir}/${name}",
    		require => Exec["export ${repo} repo for ${name}"],
    	}
	
	} else {
		exec { "copy file ${name}":
			cwd => "/home/git",
			user => "git",
			environment => "HOME=/home/git",
    		command => "cp -rf ${name} /home/git/${repo}/${subdir}",
    		creates => "/home/git/${repo}/${subdir}/${name}",
    		require => Exec["export ${repo} repo for ${name}"],
	}
	}
	
	
}