package com.c2.g4.repository;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;

import com.c2.g4.entity.User;

@Repository
public interface UsersRepository extends JpaRepository<User, String>{
	
	User findByEmail(String email);
	
    Collection<User> findAllByRole(String role);
    
    void deleteByEmail(String email);
    
    @Modifying(clearAutomatically = true)
	@Transactional
//    @Query("delete from users u where u.email = :email")
	@Query(value = "delete from users u where u.email = :email",nativeQuery = true)
	public void deleteUserbyEmail(@PathVariable("email") String email);
}
