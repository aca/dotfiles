local utils = require "mp.utils"
local mp = require "mp"

require 'mp.options'

options = {}
options.MoveToFolder = false

if package.config:sub(1,1) == "/" then
   options.DeletedFilesPath = utils.join_path(os.getenv("HOME"), "delete_file")
   ops = "unix"
else
   options.DeletedFilesPath = utils.join_path(os.getenv("USERPROFILE"), "delete_file")
   ops = "win"
end

read_options(options)


del_list = {}

function contains_item(l, i)
   for k, v in pairs(l) do
      if v == i then
         mp.osd_message("undeleting current file")
         l[k] = nil
         return true
      end
   end
   mp.osd_message("deleting current file")
   return false
end

function mark_file()
   local work_dir = mp.get_property_native("working-directory")
   local file_path = mp.get_property_native("path")
   local s = file_path:find(work_dir, 0, true)
   local final_path
   if s and s == 0 then
      final_path = file_path
   else
      final_path = utils.join_path(work_dir, file_path)
   end
   if not contains_item(del_list, final_path) then
      table.insert(del_list, final_path)
   end
end

function print_marks()
   print("bookmarks")
   for i, v in pairs(del_list) do
         -- print("marks: "..v)
         io.write(v .. "\n")
   end
end

function showList()
   local delString = "Delete Marks:\n"
   for _,v in pairs(del_list) do
      local dFile = v:gsub("/","\\")
      delString = delString..dFile:match("\\*([^\\]*)$").."; "
   end
   if delString:find(";") then
      mp.osd_message(delString)
      return delString
   elseif showListTimer then
      showListTimer:kill()
   end
end

showListTimer = mp.add_periodic_timer(1,showList)
showListTimer:kill()

function list_marks()
   if showListTimer:is_enabled() then
      showListTimer:kill()
      mp.osd_message("",0)
   else
      local delString = showList()
      if delString and delString:find(";") then
         showListTimer:resume()
         print(delString)
      else
         showListTimer:kill()
      end
   end
end

mp.add_key_binding("ctrl+DEL", "mark_file", mark_file)
mp.add_key_binding("alt+DEL", "list_marks", list_marks)
mp.register_event("shutdown", print_marks)
