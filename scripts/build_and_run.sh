# echo "compiling and running client..."
# lime test flash
echo "compiling server..."
haxe -main apg.ragdoll.server.Main -neko bin/server/server.n -cp source
echo "running server..."
neko bin/server/server.n

