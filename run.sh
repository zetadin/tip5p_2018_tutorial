#! /bin/bash

# create a water box
gmx solvate -cs tip5p.gro -o box.gro -box 2 3 4 

# energy minimization
cd em
gmx grompp -f em.mdp -c ../box.gro -p ../topol.top -o em.tpr -maxwarn 1 > prep0.log 2>&1
gmx mdrun -v -s em.tpr -c em.gro > em.log 2>&1
cd ..

# equilibration
cd equil
# nvt (Berendsen)
gmx grompp -f nvt.mdp -c ../em/em.gro -p ../topol.top -o nvt.tpr -maxwarn 1 > prep1.log 2>&1
gmx mdrun -v -s nvt.tpr  > nvt.log 2>&1

# prenpt (N-H/Berendsen)
gmx grompp -f prenpt.mdp -c nvt.tpr -t state.cpt -p ../topol.top -o prenpt.tpr -maxwarn 1 > prep2.log 2>&1
gmx mdrun -v -s prenpt.tpr > prenpt.log 2>&1

# npt (N-H/P-R)
gmx grompp -f npt.mdp -c prenpt.tpr -t state.cpt -p ../topol.top -o npt.tpr -maxwarn 1 > prep3.log 2>&1
gmx mdrun -v -s npt.tpr > npt.log 2>&1

cd ..
