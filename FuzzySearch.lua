local FuzzySearch = class("FuzzySearch")
local conf = itemConf -- 用户配置

function FuzzySearch:getSearchIDsByInputValue(searchValue,ids)
	local searchIds = {}
	local helpSort = {}
	local canNext = true
	local lastIndex = 1
	local searchCharTable = {}
	if not self:isEasternLang() then
		searchCharTabel = string.split(searchValue,"")
	else
		while canNext do
			local nextIndex
			nextIndex,canNext = utf8.next_raw(searchValue,lastIndex)
			if canNext then
				local utf8Char = string.sub(searchValue,lastIndex,nextIndex - 1)
				table.insert(searchCharTable,utf8Char)
				lastIndex = nextIndex
			else
				local utf8Char = string.sub(searCharTable,lastIndex)
				table.insert(searchCharTable,utf8Char)
			end
		end
	end

	for i, id in ipairs(ids) do
		local heroName
		itemName = string.tolower(conf:getName(id))
		local matchNum = self:fuzzySearchHelper(searchCharTable,itemName)
		if matchNum > 0 then
			table.insert(searchIDs,id)
			helpSort[tostring(id)] = matchNum
		end
	end

	table.sort(searchIDs,function(itemA,itemB)
		local matchNumA = helpSort[tostring[itemA]]
		local matchNumB = helpSort[tostring[itemB]]
		return matchNumA > matchNumB
	end)

	return searchIDs
end

-- 用户输入的字符表/匹配的已知目标名
function FuzzySearch:fuzzySearchHelper(searchCharTable,itemName)
	local matchNum = 0
 	for _,char in ipairs(searchCharTable) do
		if string.trim(char) == "" then
			-- continue
  		else
			local newChar = string.gsub(char,"%p",function(c)
   				return "%" .. c
			end)

			if string.match(itemName,newChar) then
				matchNum = matchNum + 1
   			end
 		end
  	end

	return matchNum
end

return FuzzySearch
