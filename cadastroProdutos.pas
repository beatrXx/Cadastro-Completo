unit cadastroProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Datasnap.Provider, Datasnap.DBClient,
  Data.DB, Data.Win.ADODB, Vcl.ComCtrls, System.ImageList, Vcl.ImgList,
  Vcl.ToolWin, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.Grids,
  Vcl.DBGrids;

type
  TForm1 = class(TForm)
    connection: TADOConnection;
    query: TADOQuery;
    DataSource: TDataSource;
    MClientData: TClientDataSet;
    provider: TDataSetProvider;
    MClientDatacodigo: TAutoIncField;
    MClientDataNome: TStringField;
    MClientDataDataCriacao: TDateField;
    MClientDataPreço: TFloatField;
    MClientDataModelo: TStringField;
    MClientDataEspecificações: TWideMemoField;
    MClientDataNacional: TBooleanField;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    btNovo: TToolButton;
    btExcluir: TToolButton;
    btSalvar: TToolButton;
    btCancelar: TToolButton;
    btAlterar: TToolButton;
    btAnt: TToolButton;
    btProx: TToolButton;
    PainelCadastro: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBMemo1: TDBMemo;
    DBCheckBox1: TDBCheckBox;
    procedure MClientDataAfterPost(DataSet: TDataSet);
    procedure MClientDataAfterDelete(DataSet: TDataSet);
    procedure MClientDataAfterCancel(DataSet: TDataSet);
    procedure MClientDataAfterInsert(DataSet: TDataSet);
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btAntClick(Sender: TObject);
    procedure btProxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  procedure StatusBarra(ds: TdataSet);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btAlterarClick(Sender: TObject);
begin
  MClientData.Edit;
  StatusBarra(MClientData);
end;

procedure TForm1.btAntClick(Sender: TObject);
begin
  MClientData.Prior;

end;

procedure TForm1.btCancelarClick(Sender: TObject);
begin
   MClientData.Cancel;
   StatusBarra(MClientData);

end;

procedure TForm1.btExcluirClick(Sender: TObject);
begin
   if Application.MessageBox(PChar('Deseja excluir o arquivo?'), 'Confirmação', MB_USEGLYPHCHARS + MB_DEFBUTTON2)= mrYes then
      begin
        MClientData.delete;
        StatusBarra(MClientData);

      end;

end;

procedure TForm1.btNovoClick(Sender: TObject);
begin
  MClientData.Append; // adiciona no final
  StatusBarra(MClientData);
  DBEdit2.SetFocus; //dar foco para começar a editar no nome

end;

procedure TForm1.btProxClick(Sender: TObject);
begin
  MClientData.Next;
end;

procedure TForm1.btSalvarClick(Sender: TObject);
begin
  MClientData.Post;

  Query.Close;
  MClientData.close;
  MClientData.Open;
  StatusBarra(MClientData);



end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Query.Open;
  MClientData.Open;
  statusBarra(MClientData);
end;

procedure TForm1.MClientDataAfterCancel(DataSet: TDataSet);
begin
  MClientData.CancelUpdates;
end;

procedure TForm1.MClientDataAfterDelete(DataSet: TDataSet);
begin
  MClientData.ApplyUpdates(-1);
end;

procedure TForm1.MClientDataAfterInsert(DataSet: TDataSet);
begin
  MClientDataNacional.AsBoolean := true;
end;

procedure TForm1.MClientDataAfterPost(DataSet: TDataSet);
begin
  MClientData.ApplyUpdates(-1);
end;

procedure TForm1.StatusBarra(ds: TdataSet);
begin

    btNovo.Enabled := not(ds.State in [dsEdit,dsInsert]);
    btSalvar.Enabled :=  (ds.State in [dsEdit,dsInsert]);
    btExcluir.Enabled := not(ds.State in [dsEdit,dsInsert]) and not(ds.IsEmpty);
    btAlterar.Enabled := not(ds.State in [dsEdit,dsInsert]) and not(ds.IsEmpty);
    btCancelar.Enabled :=  (ds.State in [dsEdit,dsInsert]);
    btAnt.Enabled := not(ds.State in [dsEdit,dsInsert]) and not(ds.IsEmpty);
    btProx.Enabled := not(ds.State in [dsEdit,dsInsert]) and not(ds.IsEmpty);
    PainelCadastro.Enabled :=  (ds.State in [dsEdit,dsInsert]);





end;

end.
