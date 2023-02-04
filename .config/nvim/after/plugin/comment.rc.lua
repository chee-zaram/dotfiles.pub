local status, comment = pcall(require, "Comment")
if not status then
    return
end

local comment_ft = require "Comment.ft"

comment.setup()
comment_ft.set("c", { "/* %s */", "/* %s */" })
