class git::gitolite{
	
	ssh::sshclient { "git": }
	
	package {
		"gitolite" :
			ensure => present,
			require => Ssh::Sshclient["git"],
	}
	package {
		"git" :
			ensure => present,
	}
	package {
		"git-daemon-run" :
			ensure => present,
	}
	
  	
	exec {
		"create-gitolite" :
			cwd => "/home/git",
			command => "git config --global user.email \"git@meteoritehosting.com\" && git config --global user.name \"Meteorite Hosting\" &&/usr/bin/gl-setup /home/git/.ssh/id_rsa.pub",
			creates => "/home/git/repositories",
			user => "git",
			environment => "HOME=/home/git",
			require => [Package["gitolite"],Ssh::Sshclient["git"]],
	}
	
	
	file {
		"/home/git/.gitolite/hooks/common/post-receive" :
			mode => 755,
			owner => git,
			group => git,
			source => "puppet:///modules/git/post-receive",
			require => [Package["gitolite"], Exec["create-gitolite"]]
	} ->
	exec {
		"update-gitolite" :
			cwd => "/home/git",
			command => "/usr/bin/gl-setup /home/git/.ssh/id_rsa.pub",
			creates => "/home/git/repositories/etl.git/hooks/post-receive",
			user => "git",
			environment => "HOME=/home/git",
			require => File["/home/git/.gitolite/hooks/common/post-receive"],
	} -> 
	file {
		"/usr/bin/setuprepo":
		source => "puppet:///modules/cloudbi/setup_script",
		mode=>755,
	} ->
	exec {
		"extract repo" :
			cwd => "/home/git",
			command => "setuprepo",
			creates => "/home/git/gitolite-admin",
			user => "git",
			environment => "HOME=/home/git",
			require => [File["/usr/bin/setuprepo"],File["/home/git/.gitolite/hooks/common/post-receive"]],
	} ->
	file { "/home/git/repoheader.txt":
		source => "puppet:///modules/git/repoheader.txt",
		ensure => present
		
	}
}