<cfcomponent displayname="Contacts" hint="Webservice for contacts app">
	
	<cffunction name="getContacts" access="remote" returnformat="JSON" output="no">
		<cfargument name="contactid" type="any" required="no">
		
		<cfset returnArray = ArrayNew(1) />
		<cfquery name="qContacts" datasource="testdb">
			select 	*
			from 	contacts
			<cfif isdefined("arguments.contactid") and isnumeric(arguments.contactid)>
				where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.contactid#">
			</cfif>
			order by name
		</cfquery>
		
		<cfloop query="qContacts">
			<cfset contactStruct = StructNew() />
			<cfset contactStruct["id"] = id />
			<cfset contactStruct["name"] = name />
			<cfset contactStruct["email"] = email />
			<cfset contactStruct["phone"] = phone />
			<cfset contactStruct["add1"] = add1 />
			<cfset contactStruct["add2"] = add2 />
			<cfset contactStruct["city"] = city />
			<cfset contactStruct["state"] = state />
			<cfset contactStruct["country"] = country />
			<cfset contactStruct["zip"] = zip />
			 
			<cfset ArrayAppend(returnArray,contactStruct) />
		</cfloop>

		<cfreturn SerializeJSON(returnArray)>
		
	</cffunction>
	
	
	<cffunction name="newContact" access="remote" returntype="void" output="no">
    
		<cfargument name="jsStruct" required="true" type="string"  />
		<cfset var cfStruct = DeserializeJSON(arguments.jsStruct)>
  
		<cfquery name="qNewContact" datasource="testdb">
		  insert into 
			contacts (
				name,
				email,
				phone,
				add1,
				add2,
				city,
				state,
				country,
				zip
			) values (
				<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" value="#cfStruct.name#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" value="#cfStruct.email#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="20" value="#cfStruct.phone#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" value="#cfStruct.add1#">,
				<cfif isdefined("cfStruct.add2")>
					<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" value="#cfStruct.add2#">,
				<cfelse>
					<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" value="">,
				</cfif>
				<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="50" value="#cfStruct.city#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="50" value="#cfStruct.state#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="50" value="#cfStruct.country#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="10" value="#cfStruct.zip#">
			)
		</cfquery>
  
	</cffunction>
	
	
	<cffunction name="editContact" access="remote" returntype="void" output="no">
		
		<cfargument name="contactid" type="numeric" required="yes">
		<cfargument name="jsStruct" required="true" type="string">
		<cfset var cfStruct = DeserializeJSON(arguments.jsStruct)>
  
		<cfquery name="qNewContact" datasource="testdb">
		  
			update	contacts
			set		name = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" value="#cfStruct.name#">,
					email = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" value="#cfStruct.email#">,
					phone = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="20" value="#cfStruct.phone#">,
					add1 = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" value="#cfStruct.add1#">,
					add2 = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" value="#cfStruct.add2#">,
					city = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="50" value="#cfStruct.city#">,
					state = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="50" value="#cfStruct.state#">,
					country = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="50" value="#cfStruct.country#">,
					zip = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="10" value="#cfStruct.zip#">
			where	id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.contactid#">
		</cfquery>
  
	</cffunction>
	
	
	<cffunction name="delContact" access="remote" returntype="void" output="no">
    
		<cfargument name="contactid" type="numeric" required="yes">
		
		<cfquery name="qContacts" datasource="testdb">
			delete 	from 	contacts
			where 	id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.contactid#">
		</cfquery>
  
	</cffunction>

</cfcomponent>
