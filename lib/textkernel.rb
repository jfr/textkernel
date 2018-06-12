require 'textkernel/version'
require 'savon'
require 'uri'
require 'base64'
require 'active_support/core_ext/hash'
require 'open-uri'

class Textkernel
  def initialize(attrs)
    attributes = attrs.each_with_object({}) {|(key, value), o| o[key.to_s] = value}
    @account = attributes.fetch('account')
    @username = attributes.fetch('username')
    @password = attributes.fetch('password')
    @client = ::Savon.client(wsdl: attributes.fetch('wsdl'))

    # print client.operations
    # => [:process_document_advanced, :process_document, :process_url_atomic]
  end

  def extract!(resume_path)
    response = process_document(resume_path)
    if response.http.code == 200
      document = response.body.dig(:process_document_response, :return)
      profile = Hash.from_xml(document) if document
    end
    {code: 'Success', resume: profile}
  rescue Savon::SOAPFault, Savon::HTTPError => err
    {code: 'Error', message: err.message}
  end

  private

  def process_document(file_path)
    if File.exist?(file_path)
      filename = File.basename(file_path)
      file_buf = File.read(file_path)
    else
      filename = File.basename(URI.parse(file_path).path)
      file_buf = open(file_path).read
    end
    client.call(:process_document, message: {
      account: account,
      username: username,
      password: password,
      fileName: filename,
      fileContent: Base64.encode64(file_buf)
    })
  end

  attr_reader :client, :account, :password, :username
end
