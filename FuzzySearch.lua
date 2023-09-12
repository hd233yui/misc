function getSearchIDs()
	
end

-- 用户输入的字符表/匹配的已知目标名
function fuzzySearchHelper(searchCharTable,itemName)
	local matchNum = 0
 	for _,char in ipairs(searchCharTable) do
		if string.trim(char) == "" then
			-- continue
  		else
			local newChar = string.gsub(char,"%p",function(c)
   				return "%" .. c
	  		)

			if string.match(itemName,newChar) then
				matchNum = matchNum + 1
   			end
 		end
  	end

   return matchNum
end
