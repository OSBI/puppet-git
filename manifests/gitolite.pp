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
	
  file {"/home/git/.gitolite.rc":
    source => "puppet:///modules/git/gitolite.rc",
    ensure => present,
    require => [Package["gitolite"],Ssh::Sshclient["git"]],
  }	->
	exec {
		"create-gitolite" :
			cwd => "/home/git",
			command => "git config --global user.email \"git@meteoritehosting.com\" && git config --global user.name \"Meteorite Hosting\" &&/usr/bin/gl-setup /home/git/.ssh/id_rsa.pub",
			creates => "/home/git/repositories",
			user => "git",
			environment => "HOME=/home/git",
	} -> 
	file {
		"/usr/bin/setuprepo":
		source => "puppet:///modules/cloudbi/setup_script",
		mode=>755,
	} 
	->
#	exec {
#		"extract repo" :
#			cwd => "/home/git",
#			command => "setuprepo > /tmp/out.log",
#			creates => "/home/git/gitolite-admin",
#			user => "git",
#			environment => "HOME=/home/git",
#			require => File["/usr/bin/setuprepo"],
#	} ->
	file { "/home/git/repoheader.txt":
		source => "puppet:///modules/git/repoheader.txt",
		ensure => present
		
	}
}