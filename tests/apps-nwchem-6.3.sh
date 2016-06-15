cp $NWCHEMDIR/data/default.nwchemrc $HOME/.nwchemrc
cp -R $NWCHEMDIR/examples/dirdyvtst/h3 $HOME/h3
cd $HOME/h3
mpirun -np 1 --allow-run-as-root nwchem ./h3tr1.nw > out.log
