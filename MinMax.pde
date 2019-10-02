 ArrayList <ArrayList<Noeud>> Arbre;//tableau contenant l'arbre ou chaque case est un niveau
 PShape rectangle;

int [][] mat={    {-1,-1,-1,-1,-1,-1,-1,-1},
                  {-1,-1,-1,-1,-1,-1,-1,-1},
                  {-1,-1,-1,-1,-1,-1,-1,-1},
                  {-1,-1,-1,0,1,-1,-1,-1},
                  {-1,-1,-1,1,0,-1,-1,-1},
                  {-1,-1,-1,-1,-1,-1,-1,-1},
                  {-1,-1,-1,-1,-1,-1,-1,-1},
                  {-1,-1,-1,-1,-1,-1,-1,-1}
            };
            
int[][] matPoids={{500,-150,40,30,30,40,-150,500},
                  {-150,-250,40,30,30,40,-250,-150},
                  {40,40,30,30,30,30,40,40},
                  {30,30,30,30,30,30,30,30},
                  {30,30,30,30,30,30,30,30},
                  {40,40,30,30,30,30,40,30},
                  {-150,-250,40,30,30,40,-250,-150},
                  {500,-150,40,30,30,40,-150,500}
            };
            
          
  int nbCoups=0;            
boolean finPartie=false;
int x,y,nbr=0,noirs=0,blancs=0;
boolean b=false;  PFont mapolice,policeFin;
int k=1; 
void setup(){
    rectangle = createShape(RECT,500,100,150,50);
  rectangle.setStroke(color(255));
  rectangle.setStrokeWeight(4);
  rectangle.setFill(color(0));
size(750,630,P3D); PGraphics g;
fill(25,95,22);  
rect(0,0,475,475);  
fill(255); text("Play pc",510,130);
  textSize(23); fill(25,95,22);
  rect(490,15,180,50,7);
 mapolice=loadFont("BookmanOldStyle-Italic-26.vlw");
  textFont(mapolice, 35); fill(0);
  text("OTHELLO",492,50);
   policeFin=loadFont("BernardMT-Condensed-48.vlw");

    textFont(mapolice, 30);
rect (500,100,150,50);
 text("current player",500,230,390,250);
 

} 
void draw(){ 
   
   
  //effacer l'ecran et tout redessiner pour ne pas avoir des objets en dessus d'autres
 background(g.backgroundColor);if (!GameOver(mat)) {fill(0,0,0);  text("current player",500,230,390,250); } textFont(mapolice, 35);  fill(25,95,22);   rect(490,15,180,50,7);
   rect(0,0,475,475);  String msg;
 fill(0,0,0);  text("OTHELLO",492,50);
 if (k==0)  //ellipse de current player
  { fill(0,0,0); }
  else 
  { fill(255,255,255); } 
  if(GameOver(mat))//fin de partie
  { 
    if (noirs>blancs)
    {fill(255, 0, 0); textFont(policeFin,45); msg="ECHOUE"; text(msg,500,300); }
    else 
    {fill(50,205,50);textFont(policeFin,45); msg="BRAVO"; text(msg,500,300); }
   
  }
   if (!GameOver(mat))
  ellipse(580,300,80,80);
  textFont(mapolice,35);

  fill(0,0,0); stroke(0); //les 2 jetons de score noir + blanc
  ellipse(180,555,100,100);
  fill(255,255,255); stroke(255);
  ellipse(430,550,100,100);
   stroke(0);
  lights();
  

 int f=0; 
 
 shape(rectangle);
//tour humain 
 if (mousePressed  && mouseX>500 && mouseX<500+150 && mouseY>100 && mouseY<150+50) //tour du pc
 {  rectangle.setFill(color(107));
fill (111,92,92); 

if (k==0 && b==true)
{PlayPC(); nbCoups++; }
}
else
{
fill (23,22,22); // blue when mouse not over
 if (mousePressed && mouseX/60<8 && mouseY/60<8) 
 { rectangle.setFill(color(0));
   if(k==1)
 PlayHuman(mouseY/60,mouseX/60);
 }
}
 fill(255);  text("Play pc",510,130);
 //remplir la matrice poids

 
 for(int i=0; i<8; i++)
{ strokeWeight(1);

   line(0,f,475,f);
   line(f,0,f,475);
  f+=60;
}

 noirs=0; blancs=0;
 for(int i=0;i<8; i++)
  {
    for(int j=0; j<8; j++)
     {    switch(mat[i][j])
         { case 0: fill(0,0,0);  noStroke(); ellipse(j*60+30, i*60+30, 40, 40); noirs++; break;
           case 1: fill(255,255,255);  noStroke(); ellipse(j*60+30, i*60+30, 40, 40); blancs++; break; 
          }
      }  
  }
  
   textSize(26); 

 fill(0,0,0);  text(noirs,70,550); textSize(26); 

 fill(0,0,0);  text(blancs,320,550);   


}
void PlayHuman(int x,int y)
{  b=false;
   if (mat[x][y]==-1) //humain tour
 { 
   if (k==1)//tour blanc alors jouer le coup du joueur s'il est autorisé 
  {    autoriseLigneD(k,x,y,true,mat);  autoriseLigneG(k,x,y,true,mat);   autoriseHaut(k,x,y,true,mat);  autoriseBas(k,x,y,true,mat);   autoriseDiagHautD(k,x,y,true,mat);  autoriseDiagHautG(k,x,y,true,mat);  autoriseDiagBasD(k,x,y,true,mat); autoriseDiagBasG(k,x,y,true,mat); 
  
 if(PasserTour(mat,1)==true)  //si le blanc doit passer son tour
 { print("le blanc a passé son tour");
 b=true; k=0; PlayPC(); }
   if (b)  k=0;
  }
  } 

} 



int nbJetons(int k,int [][]M)
{  int nb=0;
  for(int i=0; i<8; i++)
   { for(int j=0; j<8; j++)
      { if (M[i][j]==k) nb++; }
   }
 return nb;
}


void Heuristique(ArrayList <Noeud> feuille) //attribuer u score à chaque noeud feuille
{  
  for (int i=0; i<feuille.size(); i++)
  {   Noeud val=new Noeud();
      val=feuille.get(i); 
      val.valeur=(PoidsFeuille(feuille.get(i).joueur,feuille.get(i).PlateauJeu)); //print("i=",i,"le joueur de la feuille=",feuille.get(i).joueur);
      feuille.set(i,val);
  }
    Arbre.set(Arbre.size()-1,feuille);
 }
 
int PoidsFeuille(int couleur,int[][]M)
{ if (GameOver(M)) //si un coup engendre la fin de la partie
  { if (nbJetons(0,M)>nbJetons(1,M)) return 100000;
     else return -10000;
    
  }
  
  int vlrN=0,vlrB=0,clr,CoupJN=0,CoupJB=0; int[][]matPoidProv=new int[8][8];
  CoupJN=PosPossible(M,0).size(); //augmenter le nombre de coups jouables à noir ( liberté)
  CoupJB=PosPossible(M,1).size();  //limiter le nombre de coups jouables à blanc
  
   for (int i=0; i<8; i++)
    for (int j=0; j<8; j++)
    matPoidProv[i][j]=matPoids[i][j];
    
if (M[0][0]==couleur) {matPoidProv[0][1]=30;   matPoidProv[1][0]=30;   matPoidProv[1][1]=30; } //si on a deja les coins donc les kodamhoum sont avantageux  
if (M[0][7]==couleur) {matPoidProv[0][6]=30;  matPoidProv[1][6]=30; matPoidProv[1][7]=30; }
if (M[7][0]==couleur) {matPoidProv[6][0]=30;  matPoidProv[6][1]=30;   matPoidProv[7][1]=30; }
if (M[7][7]==couleur) {matPoidProv[6][6]=30;   matPoidProv[6][7]=30;  matPoidProv[7][6]=30; }
for(int i=0; i<8; i++)
{ for(int j=0; j<8; j++)
   {    
     if (M[i][j]==couleur) vlrN+=matPoidProv[i][j];
     
   }
   
}
if (couleur==0) clr=1; else clr=0; 
 for (int i=0; i<8; i++)
    for (int j=0; j<8; j++)
    matPoidProv[i][j]=matPoids[i][j];
   if (M[0][0]==clr) {matPoidProv[0][1]=20;   matPoidProv[1][0]=20;   matPoidProv[1][1]=20; } //si on a deja les coins donc les kodamhoum sont avantageux  
if (M[0][7]==clr) {matPoidProv[0][6]=20;  matPoidProv[1][6]=20; matPoidProv[1][7]=20; }
if (M[7][0]==clr) {matPoidProv[6][0]=20;  matPoidProv[6][1]=20;   matPoidProv[7][1]=20; }
if (M[7][7]==clr) {matPoidProv[6][6]=20;   matPoidProv[6][7]=20;  matPoidProv[7][6]=20; }
for(int i=0; i<8; i++)
{ for(int j=0; j<8; j++)
   {    
     if (M[i][j]==clr) vlrB+=matPoidProv[i][j];
     
   }
   
}
int nbN=nbJetons(0,M);
int nbB=nbJetons(1,M);
float a=0;
float b=0;

if (vlrN+vlrB!=0)
{
  a = (float)(vlrN-vlrB)/(float)(vlrN+vlrB);
}
if ((CoupJN*10+CoupJB*1)!=0)
{
  b = (float)(CoupJN*10-CoupJB*10)/(float)(CoupJN*10+CoupJB*10);
}

return (int)(a*100+b*100);
}
void GenereArbre(ArrayList<Noeud> tablvl,int level,int joueur)
{ 

  if (level==5){ 
     print("end arbre généré avecc succès avec joueur",joueur);
    
       
       MiniMax(joueur);
      }
  else  
  { 
  ArrayList <Noeud> lvl=new ArrayList <Noeud> ();
  for (int i=0; i<tablvl.size(); i++) //remplir tous les coups possibles pour chaque coup
  {  ArrayList <point> p=new ArrayList <point> ();
      p=PosPossible(tablvl.get(i).PlateauJeu,joueur);
           
      for(int j=0; j<p.size(); j++)
      { Noeud x=new Noeud();   x.PlateauJeu=new int[8][8];
        
        x.PlateauJeu=JouerCoup(tablvl.get(i).PlateauJeu,p.get(j),joueur); x.pere=i; x.level=level; x.coup=new point(p.get(j).x,p.get(j).y); x.valeur=0; x.joueur=joueur;
        lvl.add(x);     
      }
   }
   Arbre.add(lvl);
   
   if(level+1!=5)
   {if (joueur==1) joueur=0; else joueur=1; }
   if (k==0)
  GenereArbre(lvl,level+1,joueur);
  }
}

point MiniMax(int joueur)
{  point p=new point(-1,-1);
   int cp=(Arbre.size()-1);
   while(cp>0 && Arbre.get(Arbre.size()-1).size()==0) cp--;
   Heuristique(Arbre.get(cp)); //donner des poids aux feuilles pour appliquer minmax
  { int i=Arbre.size()-1;
  while(i>=0)
  { int j=0;
    while(j<Arbre.get(i).size()) 
    {  Noeud x=Arbre.get(i).get(j); //lire un noeud du niveau
        ArrayList tabProv=new ArrayList();
       while( j<Arbre.get(i).size()   && x.pere==Arbre.get(i).get(j).pere  )   //réccuperer tous les noeuds qui ont le mm pere(les freres du noeuds hada li 9rina fel x)
         { 
           tabProv.add(Arbre.get(i).get(j).valeur); j++;
         }
         int Valpere; 
         if (x.joueur==1) 
         { Valpere=Min(tabProv);         }
         else
         { Valpere=Max(tabProv);         }
        if (i>0)
        {if (x.pere!=-1) 
          {Noeud n= Arbre.get(i-1).get(x.pere);
          n.valeur=Valpere; Arbre.get(i-1).set(x.pere,n);
         }
       }
        else 
        {
          
          for (int k=0; k<Arbre.get(0).size(); k++) // juste
           {  if (Arbre.get(0).get(k).valeur==Valpere)
               { p.x=Arbre.get(0).get(k).coup.x; p.y=Arbre.get(0).get(k).coup.y; }//donner les coordonnées du poid qui est arrivé à la racine
           } print("\n");
           
            print("\nle coup joué est",p.x,p.y);
  
            autoriseLigneD(0,p.x,p.y,true,mat);  autoriseLigneG(0,p.x,p.y,true,mat);   autoriseHaut(0,p.x,p.y,true,mat);  autoriseBas(0,p.x,p.y,true,mat);   
            autoriseDiagHautD(0,p.x,p.y,true,mat);  autoriseDiagHautG(0,p.x,p.y,true,mat);  autoriseDiagBasD(0,p.x,p.y,true,mat); autoriseDiagBasG(0,p.x,p.y,true,mat);    
          k=1; 
         }
    
    
    } 
    i--;   if (i<0) break;
    }
   }
   
 
     return p;
   
}
int Min(ArrayList a)
{ int min=(int)a.get(0);
  for (int k=1; k<a.size(); k++)
  { if ((int) a.get(k) <min ) min=(int)a.get(k);
  }
return min;
}

int Max(ArrayList a)
{ int max=(int)a.get(0);
  for (int k=1; k<a.size(); k++)
  { if ((int) a.get(k) >max ) max=(int)a.get(k);
  }
return max;
}
void PlayPC()
{ 
     //tour du pc
 if (k==0)
{  Arbre=new ArrayList <ArrayList<Noeud>>(); //pour la construction de l'arbre minmax
  int [][]matProv=new int[8][8]; 
   for (int i=0; i<8; i++) 
    { for(int k=0; k<8; k++) 
      { matProv[i][k]=mat[i][k]; 
      } 
    }
   ArrayList <point> p=new ArrayList<point> ();
    p=PosPossible(matProv,k);
   // print("\nnous avons récupérer les pos possible pour noir niveau 1:");
   
    if (p.isEmpty()) {k=1; print("le noir a passé son tour"); }
  
    
    ArrayList <Noeud>  lvl=new ArrayList <Noeud> ();  //contenant les noeuds d'un niveau de l'arbre
  for(int j=0; j<p.size(); j++) //pour chaque position possible du noir
      { Noeud x=new Noeud(); 
         x.PlateauJeu=new int[8][8];
         x.PlateauJeu=JouerCoup(matProv,p.get(j),0); 
               
        x.pere=-1; x.level=0; x.coup=new point(p.get(j).x,p.get(j).y); x.valeur=0; x.joueur=0;
         lvl.add(x);     
      }
      
      Arbre.add(lvl); //ajouter le 1er niveau à l'arbre avec tous les coups
  if (k==0)
    GenereArbre(lvl,1,1); 
   
 k=1;
}
 }
  


int[][] JouerCoup(int[][]MatProv,point x,int couleur) //jouer un coup pour minmax
{ int[][] M=new int[8][8]; 
  for (int i=0; i<8; i++) 
   for (int j=0; j<8; j++)
    { M[i][j]=MatProv[i][j]; }
  autoriseLigneD(couleur,x.x,x.y,true,M);  autoriseLigneG(couleur,x.x,x.y,true,M);   autoriseHaut(couleur,x.x,x.y,true,M);  autoriseBas(couleur,x.x,x.y,true,M);   autoriseDiagHautD(couleur,x.x,x.y,true,M);  autoriseDiagHautG(couleur,x.x,x.y,true,M);  autoriseDiagBasD(couleur,x.x,x.y,true,M); autoriseDiagBasG(couleur,x.x,x.y,true,M); 

 return M;
}

boolean GameOver(int[][] mat)//évaluation de la fin de la partie
{
  if(PosPossible(mat,1).size()==0 && PosPossible(mat,0).size()==0) return true;
  else return false;
  
}

boolean PasserTour(int[][]mat, int couleur)
{ //print("taille de pospossible=" ,PosPossible(mat,couleur).size());

  if (PosPossible(mat,couleur).size()==0) return true;
  else return false;
}

ArrayList <point> PosPossible(int[][]M,int couleur) //les coups possible 
{  ArrayList <point> p=new ArrayList <point> (); 
  
  for (int i=0; i<8; i++)
  {  for(int j=0; j<8; j++)
      { if (M[i][j]==-1) //si case vide
         {  if (autoriseLigneD(couleur,i,j,false,M) || autoriseLigneG(couleur,i,j,false,M) || autoriseHaut(couleur,i,j,false,M) ||  autoriseBas(couleur,i,j,false,M)||  autoriseDiagHautD(couleur,i,j,false,M)||  autoriseDiagHautG(couleur,i,j,false,M)||  autoriseDiagBasD(couleur,i,j,false,M)||autoriseDiagBasG(couleur,i,j,false,M))    
               { point cas=new point(i,j);   p.add(cas);  } 
         }
        
      }
   
  }
 return p;
}


  boolean autoriseLigneD(int couleur,int y ,int x,boolean changer,int [][] mat)
  {  int j=y+1;  boolean bool=false;
  if (y<6)
    {if ((mat[y+1][x]!=-1) && mat[y+1][x]!=couleur)
      {  boolean fin=false;
       while(j<7 && fin==false) //verifier si c'est autorisé à gauche
        { if(mat[j][x]==couleur || mat[j][x]==-1)
            fin=true;
            else j++;
          
        }
        if (mat[j][x]==couleur) //c'est autoisé
        { bool=true;
          if (changer)
          {mat[y][x]=couleur;  b=true;
          for(int i=y; i<j ; i++)
             mat[i][x]=couleur;}
          
        }
      
       
     }
    
  }

 return bool;
  }
  
   boolean autoriseHaut(int couleur,int y ,int x,boolean changer,int [][] mat)
  {  int j=y-1;  boolean bool=false;
     if(y>1)
     { if ((mat[y-1][x]!=-1) && mat[y-1][x]!=couleur)
      {  boolean fin=false;
       while(j>0 && fin==false) //verifier si c'est autorisé à gauche
        { if(mat[j][x]==couleur || mat[j][x]==-1)
            fin=true;
            else j--;
          
        }
        if (mat[j][x]==couleur)
        { bool=true; 
         if (changer)
         { b=true; mat[y][x]=couleur;   
          for(int i=y; i>j ; i--)
          mat[i][x]=couleur; }
          
        }
    }}
   return bool;
  }
  
  
  
  
   boolean autoriseLigneG(int couleur,int y ,int x,boolean changer,int [][] mat)
  {   int i=x-1;  boolean bool=false;
     if(x>1)
     { if ((mat[y][x-1]!=-1) && mat[y][x-1]!=couleur)
    {  boolean fin=false;
       while(i>0 && fin==false) //verifier si c'est autorisé à gauche
        { if(mat[y][i]==couleur || mat[y][i]==-1)
            fin=true;
            else i--;
          
        }
        if (mat[y][i]==couleur)
        { bool=true;
          if (changer)
          {mat[y][x]=couleur;  b=true;
          for(int j=x; j>i ; j--)
          mat[y][j]=couleur;}
          
        }
    }}
  return bool;
   }
   boolean autoriseBas(int couleur,int y,int x,boolean changer,int [][] mat)
  { int i=x+1;  boolean bool=false;
     if(x<6)
     { if ((mat[y][x+1]!=-1) && mat[y][x+1]!=couleur)
    {  boolean fin=false;
       while(i<7 && fin==false) //verifier si c'est autorisé à gauche
        { if(mat[y][i]==couleur || mat[y][i]==-1)
            fin=true;
            else i++;
          
        }
        if (mat[y][i]==couleur) //c'est autorisé
        {   bool=true;
          if (changer)
         { mat[y][x]=couleur;  b=true;
          for(int j=x; j<i ; j++)
           mat[y][j]=couleur;}
          
        }
        
    }}
   return bool;
  }
  
   boolean autoriseDiagHautD(int couleur,int y ,int x,boolean changer,int [][] mat)
  {  
    int j=y-1,i=x+1;  boolean bool=false;
  if ((y>0) && (x<6))
    {if ((mat[y-1][x+1]!=-1) && mat[y-1][x+1]!=couleur)
      {  boolean fin=false;
       while(j>0 && i<7 && fin==false) //verifier si c'est autorisé à gauche
        { if(mat[j][i]==couleur || mat[j][i]==-1)
            fin=true;
            else {j--;i++;}
          
        }
        if (mat[j][i]==couleur) //c'est autoisé
        {  bool=true;
          if (changer)
         { mat[y][x]=couleur;  b=true; int a=y; int q=x;
          while (q<i &&  a>j )
            {  mat[a][q]=couleur; a--;q++;}
         }
        }
       
     }
    }
    return bool;
  }

  
  
   boolean autoriseDiagHautG(int couleur,int y,int x,boolean changer,int [][] mat)
  { 
  int j=y-1,i=x-1; boolean bool=false;
  if ((y>0) && (x>0))
    {if ((mat[y-1][x-1]!=-1) && mat[y-1][x-1]!=couleur)
    {  boolean fin=false;
       while(j>0 && i>0 && fin==false) //verifier si c'est autorisé à gauche
        { if(mat[j][i]==couleur || mat[j][i]==-1)
            fin=true;
            else {j--;i--;}
          
        }
        if (mat[j][i]==couleur) //c'est autoisé
        { bool=true;
          if (changer)
         { mat[y][x]=couleur;  b=true; int a=y; int q=x;
          while( a>j  && q>i)
            { mat[a][q]=couleur; a--; q--;}
         }
        }
       
    } }
  return bool;
  }
  
   boolean autoriseDiagBasD(int couleur,int y,int x,boolean changer,int [][] mat)
  { 
   int j=y+1,i=x+1; boolean bool=false;
  if ((y<6) && (x<6))
    {if ((mat[y+1][x+1]!=-1) && mat[y+1][x+1]!=couleur)
    {  boolean fin=false;
       while(j<7 && i<7 && fin==false) //verifier si c'est autorisé à gauche
        {   if(mat[j][i]==couleur || mat[j][i]==-1)
              fin=true;
            else {j++;i++;}
        }
        if (mat[j][i]==couleur) //c'est autoisé
        { bool=true;
          if (changer)
          {mat[y][x]=couleur;  b=true; int a=y; int q=x;
          while( a<j && q<i)
          {
             mat[a][q]=couleur; a++; q++;}
          }
        }
       
    } }
    return bool;
  }
  
    boolean autoriseDiagBasG(int couleur,int y,int x,boolean changer,int [][] mat)
  { 
  int j=y+1,i=x-1; boolean bool=false;
  if ((y<6) && (x>0))
    {if ((mat[y+1][x-1]!=-1) && mat[y+1][x-1]!=couleur)
    {  boolean fin=false;
       while(j<7 && i>0 && fin==false) //verifier si c'est autorisé à gauche
        { if(mat[j][i]==couleur || mat[j][i]==-1)
            fin=true;
            else {j++;i--;}
          
        }
        if (mat[j][i]==couleur) //c'est autoisé
        {  bool=true;
         if (changer)
         { mat[y][x]=couleur;  b=true; int a=y; int q=x;
         while(a<j && q>i)
             { mat[a][q]=couleur; a++; q--;}
         }
        }
       
    } }
   
  return  bool;
  }
  
  
   public class point{
     int x,y;  
     point(){}
     point(int i,int j)
     {x=i; y=j;
     }
     
   }
   
   public class Noeud{
     int[][]PlateauJeu; point coup; int pere,level; int valeur,joueur;
     Noeud (){}
     Noeud(int[][]mat,point c,int p)
     { PlateauJeu=mat; coup=c; pere=p;
       
     }
     
   }
