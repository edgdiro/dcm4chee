# -*- encoding: utf-8 -*-
module Dcm4chee
  class TrashedInstance
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject
    include Trashable

    storage_names[Dcm4chee.config.repository_name] = 'priv_instance'
    table_name 'priv_instance'

    # @return [Integer] 主键
    property :id, Serial, field: 'pk'

    # @return [Integer] 指向{Series}的外键
    property :trashed_series_id, Integer, field: 'series_fk'

    # @return [DateTime] 实例创建时间
    property :created_at, DateTime, field: 'created_time'

    # @return [String] DICOM SOP Instance UID(0008,0018)
    property :sop_instance_uid, Text, field: 'sop_iuid'

    dicom_field 'inst_attrs'

    belongs_to :trashed_series, 'Dcm4chee::TrashedSeries'
    has n, :trashed_dicom_files, 'Dcm4chee::TrashedDicomFile'

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
