module EtAtosFileTransfer
  module V1
    class FileTransfersController < ::EtAtosFileTransfer::ApplicationController
      def index
        render locals: { files: EtAtosFileTransfer::ExportedFile.for_system(external_system) }
      end

      def download
        filename = params.require(:filename)
        file = EtAtosFileTransfer::ExportedFile.for_system(external_system).find_by(filename: filename)
        return not_found if file.nil?
        temp_file = Tempfile.new(file.filename)
        file.download_blob_to(temp_file.path)
        send_file temp_file, filename: file.filename
      end

      def delete
        filename = params.require(:filename)
        file = EtAtosFileTransfer::ExportedFile.for_system(external_system).find_by(filename: filename)
        return not_found if file.nil?
        file.destroy
        head :ok
      end

      def upload
        head :ok
      end

      private

      def not_found
        head :not_found
      end
    end
  end
end
