# echo "compiling and running client..."
# lime test neko &
echo "compiling server..."
haxe -lib ash -main apg.ragdoll.server.Main -neko bin/server/server.n -cp source
echo "running server..."
neko bin/server/server.n

