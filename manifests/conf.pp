define git::conf($ensure=present) {


	common::concatfilepart {"repo-${name}":
    	ensure  => $ensure,
    	file    => "/home/git/gitolite-admin/conf/gitolite.conf",
    	content => template("git/default-repo.erb"),
    	header => "/tmp/header.txt"
     	}


}