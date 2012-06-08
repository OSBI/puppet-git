define git::gitoliteimport($repo, $directory=false, $subdir="", $file){
	
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
    		command => "cp -rf ${file} /home/git/${repo}/${subdir}",
    		creates => "/home/git/${repo}/${subdir}/${file}",
    		require => Exec["export ${repo} repo for ${name}"],
    	}
	  exec { "commit ${repo} for ${name}":
		cwd => "/home/git/${repo}",
		user => "git",
		environment => "HOME=/home/git",
    	command => "git add * ; git commit -a -m \"import ${file}\" ; git push && mkdir -p /home/git/committed/ && touch /home/git/committed/${name}",
    	creates => "/home/git/committed/${name}"
	}
	} else {
		exec { "copy file ${name}":
			cwd => "/home/git",
    		command => "cp -rf ${file} /home/git/${repo}/${subdir}",
    		creates => "/home/git/${repo}/${subdir}/${name}",
    		require => Exec["export ${repo} repo for ${name}"],
	}
	exec { "commit ${repo} for ${name}":
		cwd => "/home/git/${repo}",
		user => "git",
		environment => "HOME=/home/git",
    	command => "git add * ; git commit -a -m \"import ${name}\" ; git push && mkdir -p /home/git/committed/ && touch /home/git/committed/${name}",
    	creates => "/home/git/committed/${name}"
	}
	}
	
	
}