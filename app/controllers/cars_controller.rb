class CarsController < ApplicationController

  def index
    @cars = Car.all
  end

  def new_import
    @upload_csv_form = UploadCsvFrom.new
  end

  def save_csv
    @upload_csv_form = UploadCsvFrom.new(car_params)

    if @upload_csv_form.save
      redirect_to import_preview_car_path(@upload_csv_form.import_record)
    else
      render :new_import
    end
  end

  def cancel_import
    ImportRecord.find(params[:id]).destroy
    flash[:notice] = "Import was canceled."
    redirect_to root_path
  end

  def import_preview
    @presenter = ImportPreviewPresenter.new(import_record_id: params[:id])
    @presenter.validate_rows
  end

  def import
    CarImport::Worker.call!(params[:id])
    flash[:notice] = "Import was successfull!"
    redirect_to root_path
  end

  def delete_all
    # NOTE: Might be worth to create a repository.
    Car.delete_all
    ImportRecord.delete_all

    flash[:notice] = "You have removed all cars!"
    redirect_to root_path
  end

  private

    def car_params
      params.fetch(:upload_csv_from, {}).permit(:file)
    end

end
