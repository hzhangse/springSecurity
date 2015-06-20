package com.train.ldap;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.ldap.userdetails.LdapAuthoritiesPopulator;
import org.springframework.security.ldap.userdetails.LdapAuthority;

public class CompanyAuthoritiesPopulator implements LdapAuthoritiesPopulator {

	@Override
	public Collection<GrantedAuthority> getGrantedAuthorities(
			DirContextOperations userData, String username) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new LdapAuthority("ROLE_USER",""));
		return authorities;
	}

}
